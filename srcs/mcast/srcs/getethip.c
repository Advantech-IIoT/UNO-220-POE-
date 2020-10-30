#include <stdio.h>
#include <unistd.h>
#include <string.h> /* for strncpy */

#include <sys/types.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <netinet/in.h>
#include <net/if.h>
#include <arpa/inet.h>

int main(int argc, char *argv[]){
     int fd, ret=0;
     struct ifreq ifr;
     fd = socket(AF_INET, SOCK_DGRAM, 0);
     ifr.ifr_addr.sa_family = AF_INET;
     strncpy(ifr.ifr_name, argv[1]?argv[1]:"eth0", IFNAMSIZ-1);
     ret=ioctl(fd, SIOCGIFADDR, &ifr);
     if(ret!=0) goto err; 
     printf("%s\n", inet_ntoa(((struct sockaddr_in *)&ifr.ifr_addr)->sin_addr));
     close(fd);
     return 0;
err: 
     printf("ret: %d\n", ret);
     close(fd);
     return -1;
}
