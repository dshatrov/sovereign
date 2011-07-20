#include <stdio.h>
#include <unistd.h>

int main (void)
{
    execl ("/bin/bash", "/bin/bash", "/start.sh", (char*) NULL);
    perror ("exec (\"/bin/bash\", \"/start.sh\") failed");
    return -1;
}

