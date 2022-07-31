#!/bin/bash

stumpish eval "(ql:quickload :slynk)"
stumpish eval "(slynk:create-server :dont-close t)"
