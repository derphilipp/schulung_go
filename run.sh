#!/bin/bash

docker run --rm -v `pwd`:/slides -v ~:/home/user astefanutti/decktape http://derphilipp.github.io/schulung_go slides.pdf
