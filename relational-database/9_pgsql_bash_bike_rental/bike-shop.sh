#!/bin/bash

echo -e "\n~~~~~ Bike Rental Shop ~~~~~\n"

MAIN_MENU() {
  echo How may I help you?
  echo -e "
  1. Rent a bike
  2. Return a bike
  3. Exit"
  read MAIN_MENU_SELECTION
}

RENT_MENU() {
  echo Rent Menu
}

RETURN_MENU() {
  echo Return Menu
}

EXIT() {
  echo Thank you for stopping in.
}


MAIN_MENU



