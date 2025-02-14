#!/bin/bash


source venv/bin/activate

cd Server

uvicorn main:app --reload

