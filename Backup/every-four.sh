#!/bin/bash
exec test "$((10#$(date +%W)%4))" -eq 1