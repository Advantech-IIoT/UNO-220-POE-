/* Send Multicast Datagram code example. */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <sys/ioctl.h>
#include <net/if.h>
int getethip(char *eth, char *buf){
     int fd, ret=0;
     struct ifreq ifr;
     fd = socket(AF_INET, SOCK_DGRAM, 0);
     ifr.ifr_addr.sa_family = AF_INET;
     strncpy(ifr.ifr_name, eth, IFNAMSIZ-1);
     ret=ioctl(fd, SIOCGIFADDR, &ifr);
     if(ret!=0) goto err; 
     //printf("%s\n", inet_ntoa(((struct sockaddr_in *)&ifr.ifr_addr)->sin_addr));
     sprintf(buf, "%s: %s", eth, inet_ntoa(((struct sockaddr_in *)&ifr.ifr_addr)->sin_addr));
     close(fd);
     return 0;
err: 
     printf("ret: %d\n", ret);
     close(fd);
     return -1;
}
struct in_addr localInterface;
struct sockaddr_in groupSock;
int sd;
char databuf[1024] = "Multicast test message lol!";
int datalen = sizeof(databuf);
int main (int argc, char *argv[]){
    /* Create a datagram socket on which to send. */
    sd = socket(AF_INET, SOCK_DGRAM, 0);
    if(sd < 0){
        perror("Opening datagram socket error");
        exit(1);
    }else printf("Opening the datagram socket...OK.\n");
    /* Initialize the group sockaddr structure with a */
    /* group address of 225.1.1.1 and port 5555. */
    memset((char *) &groupSock, 0, sizeof(groupSock));
    groupSock.sin_family = AF_INET;
    groupSock.sin_addr.s_addr = inet_addr("226.1.1.1");
    groupSock.sin_port = htons(4321);
    /* Disable loopback so you do not receive your own datagrams.
       {
       char loopch = 0;
       if(setsockopt(sd, IPPROTO_IP, IP_MULTICAST_LOOP, (char *)&loopch, sizeof(loopch)) < 0)
       {
       perror("Setting IP_MULTICAST_LOOP error");
       close(sd);
       exit(1);
       }
       else
       printf("Disabling the loopback...OK.\n");
       }
*/
    /* Set local interface for outbound multicast datagrams. */
    /* The IP address specified must be associated with a local, */
    /* multicast capable interface. */
    /* localInterface.s_addr = inet_addr("203.106.93.94"); */
    localInterface.s_addr = INADDR_ANY;
    if(setsockopt(sd, IPPROTO_IP, IP_MULTICAST_IF, (char *)&localInterface, sizeof(localInterface)) < 0){
        perror("Setting local interface error");
        exit(1);
    }else
        printf("Setting the local interface...OK\n");
    /* Send a message to the multicast group specified by the*/
    /* groupSock sockaddr structure. */
    /*int datalen = 1024;*/
    if(getethip(argv[1]?argv[1]:"eth0", databuf)!=0) goto err;
    while(1){
        if(sendto(sd, databuf, datalen, 0, (struct sockaddr*)&groupSock, sizeof(groupSock)) < 0)
            {perror("Sending datagram message error");}
        else
            printf("Sending datagram message...OK\n");
	sleep(5);
    }
    /* Try the re-read from the socket if the loopback is not disable
     if(read(sd, databuf, datalen) < 0)
     {
       perror("Reading datagram message error\n");
       close(sd);
       exit(1);
     }
     else
     {
       printf("Reading datagram message from client...OK\n");
       printf("The message is: %s\n", databuf);
     }
    */
    return 0;
err:
    close(sd);
    return -1;
}
