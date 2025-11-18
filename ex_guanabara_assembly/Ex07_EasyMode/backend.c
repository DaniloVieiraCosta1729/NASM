/*
    --- Servidor, Banco --- 09/11/2025

    Aqui eu vou inicializar o servidor e o banco de dados. 
    Acho que o código pode ficar um pouco bagunçado, então talvez eu defina algumas funções em outros arquivos para deixar o código mais fácil de ler.
    Vou tentar implementar mais coisas legais que eu tenho aprendido, como usar bitmasks quando possível. 
    Por exemplo, para responder algumas requisições típicas eu posso fazer uma mascara que informe o que usar ou não usar na resposta. Talvez nem valha a pena, mas vamos ver na hora.
*/

#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/sendfile.h>
#include <unistd.h>
#include <stdlib.h>

#define GET             0
#define POST            1
#define DELETE          2
#define PATCH           4
#define PUT             8

#define NOTIMPLEMENTED "HTTP/1.1 501 Not Implemented\r\nContent-Type: text/plain\r\nContent-Length: 49\r\nConnection: close\r\n\r\nO metodo nao e suportado, amigo."

enum connecting {HALTED, RUNNING};
volatile enum connecting serving = RUNNING;

const char * ContentType(char *filename);
int obtainMethod(const char * buffer);
void handleGET(int clientFD, char * request);
void handlePOST(int clientFD, char * request);

int main()
{
    int serverFD = socket(AF_INET, SOCK_STREAM, 0);

    struct sockaddr_in serverAddr;
        serverAddr.sin_addr.s_addr = INADDR_ANY;
        serverAddr.sin_family = AF_INET;
        serverAddr.sin_port = htons(8080);

    socklen_t serverLen = sizeof(serverAddr);
    if ((bind(serverFD, (struct sockaddr *)&serverAddr, serverLen)) < 0)
    {
        perror("Bind");
        return -1;
    }

    if ((listen(serverFD, 5)) < 0)
    {
        perror("Listen");
        return -1;
    }
    
    struct sockaddr_in clientAddr;
    socklen_t clientLen = sizeof(clientAddr);
    while (serving)
    {
        int clientFD;
        if ((clientFD = accept(serverFD, (struct sockaddr*)&clientAddr, (socklen_t*)&clientLen)) < 0)
        {
            perror("Accept");
            break;
        }

        char buffer[3000];
        recv(clientFD, buffer, 3000, 0);
        buffer[2999] = '\0';
        printf("REQ:\n%s\n", buffer);


        int methodMask = obtainMethod(buffer);

        switch (methodMask)
        {
        case GET:
            handleGET(clientFD, buffer);
            break;

        case POST:
            handlePOST(clientFD, buffer);
            break;        
        
        default:
            printf("\nRequisicao: %s", buffer);
            send(clientFD, NOTIMPLEMENTED, strlen(NOTIMPLEMENTED), 0);
            break;
        }

        close(clientFD);        
    }

    return 0;
}

int obtainMethod(const char * buffer) // não gosto da ideia de aumentar a pilha para fazer uma tarefa dessas, mas dessa vez quero manter o código o mais fácil de ler que eu puder.
{
    if (!strncmp(buffer,"GET", 3))
    {
        return GET;
    }
    if (!strncmp(buffer,"POST", 4))
    {
        return POST;
    }
    if (!strncmp(buffer,"DELETE", 6))
    {
        return DELETE;
    }
    if (!strncmp(buffer,"PATCH", 5))
    {
        return PATCH;
    }
    if (!strncmp(buffer,"PUT", 3))
    {
        return PUT;
    }

    return -1;    
}

void handleGET(int clientFD, char * request)
{
    char * filename = request + 5;
    filename[strcspn(filename," ")] = '\0';

    char path[50];
    sprintf(path, "./front/%s", filename);

    int fileFD;

    if ((fileFD = open(path, O_RDONLY)) < 0)
    {
        perror("Open file");
        printf("Caminho: %s falhou.", path);

        char * msg = "Arquivo não encontrado...";
        char notFound[256];
        sprintf(notFound, "HTTP/1.1 404 Not Found\r\nContent-Type: text/plain\r\nContent-length: %ld\r\nConnection: close\r\n\r\n%s", strlen(msg), msg);

        send(clientFD, notFound, strlen(notFound), 0);
        return;
    }

    struct stat filestatus;

    fstat(fileFD, &filestatus);

    char httpheader[256];
    const char * tipo = ContentType(filename);

    sprintf(httpheader, "HTTP/1.1 200 OK\r\nContent-Type: %s\r\nContent-Length: %ld\r\nConnection: close\r\n\r\n", tipo, filestatus.st_size);

    send(clientFD, httpheader, strlen(httpheader), 0);
    sendfile(clientFD, fileFD, 0, filestatus.st_size);

    close(fileFD);

}

void handlePOST(int clientFD, char * request)
{
    int length;

    char * contetLength = strstr(request, "Content-Length: ");

    if (!contetLength)
    {
        printf("Nao ha content-length.");
        return;
    }

    sscanf(contetLength, "Content-Length: %d", &length);

    char * body = strstr(request, "\r\n\r\n");

    if (!body)
    {
        printf("Esse request ta podre. Nao tem final o trem!!");
        return;
    }

    body += 4;

    if ((int)strlen(body) < length) // body tem quase 3k de tamanho, mas isso n é um problema nesse caso. Vamos fazer a validacao por motivos de porque sim.
    {
        printf("Eu prefiro o resquest inteiro do o request todo! - Chaves");
        return;
    }

    // essa vai ser, praticamente, a primeira vez que aloco memória em um projeto. 

    char * data = (char *)malloc(length + 1);

    if (!data)
    {
        printf("Problema na alocação de memória do body no handler do POST.");
        return;
    }

    memcpy(data, body, length);    

    data[length] = '\0';

    char * nome = (char *)malloc(strcspn(data, "&"));
    memcpy(nome, data, strcspn(data, "&") + 1);
    nome[strcspn(data, "&")] = '\0';

    char * cpf = strchr(data, '&') + 1;

    char msg[256];
    sprintf(msg,"o nome do aluno e: %s\n\no cpf do aluno e: %s", nome, cpf);

    printf("%s\n", msg);

    char httpHeader[512];

    sprintf(httpHeader, "HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\nContent-Length: %ld\r\nConnection: close\r\n\r\n%s", strlen(msg), msg);

    send(clientFD, httpHeader, strlen(httpHeader), 0);

    free(data);
    free(nome);
}

const char * ContentType(char *filename)
{
    if (strstr(filename, ".html"))
    {
        return "text/html";
    }
    if (strstr(filename, ".css"))
    {
        return "text/css";
    }
    if (strstr(filename, ".png"))
    {
        return "image/png";
    }
    if (strstr(filename, ".js"))
    {
        return "application/javascript";
    }
    if (strstr(filename, ".mp3"))
    {
        return "audio/mpeg";
    }

    return "application/octet-stream";    
}