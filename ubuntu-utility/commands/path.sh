#!/bin/env bash

path() {

     echo $PATH | tr ':' '\n' || echo "command 'path' failed"

}
