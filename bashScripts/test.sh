#!/bin/bash

mapfile -t lsoutput < <(ls -la)
echo $lsoutput
