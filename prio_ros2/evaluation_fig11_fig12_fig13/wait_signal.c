/*
 * wait_signal.c
 *
 * Usage: ./wait_signal <IP address> <port>
 *
 * Listens for a UDP message on the specified IP address and port.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <netinet/in.h>

#define BUFFER_SIZE 1024

int main(int argc, char *argv[]) {
    if (argc != 3) {
        fprintf(stderr, "Usage: %s <IP address> <port>\n", argv[0]);
        exit(EXIT_FAILURE);
    }

    char *ip = argv[1];
    int port = atoi(argv[2]);
    if (port <= 0) {
        fprintf(stderr, "Invalid port: %s\n", argv[2]);
        exit(EXIT_FAILURE);
    }

    // Create UDP socket
    int sockfd;
    if ((sockfd = socket(AF_INET, SOCK_DGRAM, 0)) < 0) {
        perror("Failed to create socket");
        exit(EXIT_FAILURE);
    }

    // Set up address structure (bind to the specified IP and port)
    struct sockaddr_in addr;
    memset(&addr, 0, sizeof(addr));
    addr.sin_family = AF_INET;
    addr.sin_port = htons(port);
    if (inet_aton(ip, &addr.sin_addr) == 0) {
        fprintf(stderr, "Invalid IP address: %s\n", ip);
        close(sockfd);
        exit(EXIT_FAILURE);
    }

    // Bind the socket
    if (bind(sockfd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
        perror("bind failed");
        close(sockfd);
        exit(EXIT_FAILURE);
    }

    printf("Listening for messages on IP %s, port %d...\n", ip, port);

    while (1) {
        char buffer[BUFFER_SIZE];
        struct sockaddr_in sender;
        socklen_t sender_len = sizeof(sender);
        ssize_t n = recvfrom(sockfd, buffer, BUFFER_SIZE - 1, 0,
                             (struct sockaddr *)&sender, &sender_len);
        if (n < 0) {
            perror("recvfrom failed");
            continue;
        }
        buffer[n] = '\0';  // Null-terminate the received string
        printf("Received from %s:%d : %s\n",
               inet_ntoa(sender.sin_addr), ntohs(sender.sin_port), buffer);
        break;
    }

    close(sockfd);
    return 0;
}

