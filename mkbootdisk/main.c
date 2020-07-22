#include <stdio.h>
#include <stdint.h>
#include <libgen.h>
#include <unistd.h>
#include <sys/wait.h>
#include <sys/stat.h>


extern char **environ;

int execwait(char **args)
{
	pid_t pid = fork();
	if (pid == -1) {
		printf("Fork error\n");
		return 1;
	}

	if (pid) {
		wait(NULL);
		return 0;
	} else {
		execve(args[0], args, environ);
		printf("Error running `%s`\n", args[0]);
		return 1;
	}
}

int main(int argc, char **argv)
{
	int err;

	if (argc != 2 && argc != 3) {
		printf("Bad arguments. Usage:\n\t%s <input.s> [outfile=bootdisk.bin]\n", basename(argv[0]));
		return 1;
	}
	char *outfile;
	if (argc == 3)
		outfile = argv[2];
	else
		outfile = "bootdisk.bin";

	err = access(argv[1], R_OK);
	if (err) {
		printf("Can't read file \"%s\"\n", argv[1]);
		return 1;
	}

	char *as_args[] = {
		"/usr/bin/as",
		"-o", "/tmp/prog.o",
		argv[1],
		(char *) NULL
	};
	err = execwait(as_args);
	if (err)
		return err;

	char *ld_args[] = {
		"/usr/bin/ld",
		"-e", "0",
		"--oformat", "binary",
		"-o", "/tmp/prog.bin",
		"-Ttext", "0x7C00",
		"/tmp/prog.o",
		(char *) NULL
	};
	err = execwait(ld_args);
	if (err)
		return err;

	struct stat progstat;
	err = stat("/tmp/prog.bin", &progstat);
	if (err)
		return 1;
	if (progstat.st_size > 510) {
		printf("Program can't fit into boot sector\n");
		return 1;
	}

	uint8_t bootsect[512] = {0};
	bootsect[511] = 0xAA;
	bootsect[510] = 0x55;

	FILE *progfile = fopen("/tmp/prog.bin", "rb");
	fread(bootsect, 1, progstat.st_size, progfile);
	fclose(progfile);

	FILE *outf = fopen(outfile, "wb");
	fwrite(bootsect, sizeof(bootsect[0]), sizeof(bootsect), outf);
	fclose(outf);
}
