import 'dart:math';

Random random = Random();

double doubleInRange(num start, num end) => random.nextDouble() * (end - start) + start;
