# 2. Óra / Gy0 / Ismétlés

## [Fileok letöltése](https://github.com/rontap/elteik-web/raw/main/teaching/opsys/materials/gy0-revision/gy0-opsys.zip)

[https://github.com/rontap/elteik-web/raw/main/teaching/opsys/materials/gy0-revision/gy0-opsys.zip](https://github.com/rontap/elteik-web/raw/main/teaching/opsys/materials/gy0-revision/gy0-opsys.zip)

## Fileok fordítása

```shell
 gcc -Wall -Werror=vla -pthread -lrt -std=c11 -pedantic ./open_fopen.c && ./a.out text.txt
```

## Óra Outline

- [ ]  Adminsztráció, A tárgyról röviden, jelenlét `5p`
- [ ]  C és POSIX/UNIX-ról `5p`
- [ ]  Interaktív: Mit tudunk a C-ről? Manpages, gcc `5p`
- [ ]  Pointerek recap + Bináris vagy, és `10p`
- [ ]  `strings.c 10p` malloc, pointer magic, strlen
- [ ]  `open_fopen.c 5p` FILE* gets, puts
- [ ]  `arg.c, directory.c 5p` char**
- [ ]  `file.c 5p` improve code
- [ ]  _optional_ `fork` intro

## Opcionális telepítendő dolgok
`fopen` és társai manpage
```shell
sudo apt install manpages-dev
sudo apt install manpages-posix-dev
```
Színes manpage
```shell
exp="export LESS_TERMCAP_mb=$'\e[1;32m'"  
 "export LESS_TERMCAP_md=$'\e[1;32m'" 
 "export LESS_TERMCAP_me=$'\e[0m'" 
 "export LESS_TERMCAP_se=$'\e[0m'" 
 "export LESS_TERMCAP_so=$'\e[01;33m'" 
 "export LESS_TERMCAP_ue=$'\e[0m'" 
 "export LESS_TERMCAP_us=$'\e[1;4;31m'" 
echo $exp > ~/.bashrc 
source ~/.bashrc
```

## Órai Munka

- `file.c` -ben az file írást átírni `size_t` használhatára
- `libopsys.h` feltöltése

[Kezdőlap](index.md)
|
[Vissza](prep.md)
|
[Tovább](gy0.md)
