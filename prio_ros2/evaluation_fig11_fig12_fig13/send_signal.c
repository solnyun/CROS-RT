/*
 * send_signal.c
 *
 * Usage: ./send_signal <IP address> <port>
 *
 * Sends a UDP message to the specified IP address and port.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <netinet/in.h>

#define MESSAGE "Hello, signal!"

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

    // Set destination address (specified IP and port)
    struct sockaddr_in addr;
    memset(&addr, 0, sizeof(addr));
    addr.sin_family = AF_INET;
    addr.sin_port = htons(port);
    if (inet_aton(ip, &addr.sin_addr) == 0) {
        fprintf(stderr, "Invalid IP address: %s\n", ip);
        close(sockfd);
        exit(EXIT_FAILURE);
    }

    // Send the message
    ssize_t sent = sendto(sockfd, MESSAGE, strlen(MESSAGE), 0,
                          (struct sockaddr *)&addr, sizeof(addr));
    if (sent < 0) {
        perror("sendto failed");
        close(sockfd);
        exit(EXIT_FAILURE);
    }

    printf("Message sent to IP %s, port %d.\n", ip, port);

    close(sockfd);
    return 0;
}

