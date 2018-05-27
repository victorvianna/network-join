#ifndef	IOUTIL_H
#define IOUTIL_H

#include "relation.h"
#include <cstddef>

std::istream& operator>>(std::istream& is, Relation<int>& rel);

std::ostream& operator<<(std::ostream& os, Relation<int>& rel);

std::size_t read_arity(std::string& filename);

void read_relation(std::string& filename, Relation<int>& rel);

void write_relation(const std::string& filename, Relation<int>& rel);

#endif
