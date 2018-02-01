#include <stdio.h>  /* wprintf, _fileno */
#include <stdlib.h> /* EXIT_FAILURE, EXIT_SUCCESS */
#include <io.h>     /* _setmode */
#include <fcntl.h>  /* _O_U8TEXT */

int main(int argc, char *argv[])
{
    int exitCode = EXIT_FAILURE;
    const wint_t THORN_CHAR = 222;

    // Turn on wchar_t to UTF-8 translation for stdout (wprintf).
    // This requires all output to be wide character. Printf will fail.
    if (_setmode(_fileno(stdout), _O_U8TEXT) != -1) {
        if (wprintf(L"%c", THORN_CHAR) != -1) {
            exitCode = EXIT_SUCCESS;
        }
        else {
            perror("wprintf");
        }
    }
    else {
        perror("_setmode");
    }

    return exitCode;
}
