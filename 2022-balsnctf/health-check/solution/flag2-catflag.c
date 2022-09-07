#include <stdlib.h>
#include <unistd.h>

int main() {
    setregid(1000, 1000);
    system("cat ../../flag2 > status.json");
    return 0;
}
