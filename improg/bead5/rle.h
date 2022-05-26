#ifndef RLE_H
#define RLE_H
struct Pair {
    char c;
    int n;
};
struct Encoded {
    int length;
    struct Pair *arr[];
};
struct Encoded *encode(char[]);

char *decode(struct Encoded *enc);

#endif //RLE_H
