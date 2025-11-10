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

#define GET             0
#define POST            1
#define DELETE          2
#define PATCH           4
#define PUT             8

enum connecting {HALTED, RUNNING};
volatile enum connecting serving = RUNNING;

int servidor()
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
        if ((clientFD = accept(serverFD, (struct sockaddr*)&clientAddr, clientLen)) < 0)
        {
            perror("Accept");
            break;
        }

        char buffer[1000];
        recv(clientFD, buffer, 999, 0);
        buffer[1000] = '\0';

        int methodMask = obtainMethod(&buffer);
        
    }

    return 0;
}

int obtainMethod(const char * buffer) // não gosto da ideia de aumentar a pilha para fazer uma tarefa dessas, mas dessa vez quero manter o código o mais fácil de ler que eu puder.
{
    if (strncmp(buffer,"GET", 3))
    {
        return GET;
    }
    if (strncmp(buffer,"POST", 4))
    {
        return POST;
    }
    if (strncmp(buffer,"DELETE", 6))
    {
        return DELETE;
    }
    if (strncmp(buffer,"PATCH", 5))
    {
        return PATCH;
    }
    if (strncmp(buffer,"PUT", 3))
    {
        return PUT;
    }

    return -1;    
}
