//
// Created by atatai on 18/12/2021.
//
#include <set>
#include <unordered_set>
#include <string>
#include <algorithm>
#include <iterator>
#include <string>
#include <numeric>
#include <vector>
#include <iostream>

#ifndef CPP_SETOPS_H
#define CPP_SETOPS_H

template<class T>
class set_operations {

    typedef typename std::unordered_set<T>::iterator sit;
    std::unordered_set<T> set;
    bool is_compl;

public:

    template<class G = std::less<T> >
    set_operations(std::set<T, G> _set) :
            set(_set.begin(), _set.end()), is_compl(false) {};


    void complement() {
        is_compl = !is_compl;
    };

    template<class G = std::less<T> >
    void set_union(std::set<T, G> another) {
        std::unordered_set<T> news(another.begin(), another.end());

        if (is_compl) {
            sit it = news.begin();
            while (it != news.end()) {
                set.erase(*it);
                it++;
            }
        } else {
            set.insert(news.begin(), news.end());
        }

    };

    T &operator+=(std::set<T> &other) {
        set_union(other);
        return this;
    }

    void insert(T val) {
        set.insert(val);
    }

    bool subset(std::set<T> subs) const {
        std::unordered_set<T> news(subs.begin(), subs.end());
        sit it = news.begin();
        while (it != news.end()) {
            if (set.find(*it) == set.end()) return is_compl;
            it++;
        }
        return !is_compl;
    }

    bool contains(const T val) const {
        bool cont = set.find(val) != set.end();
        if (is_compl) return !cont; else return cont;
    };

};

#endif //CPP_SETOPS_H
