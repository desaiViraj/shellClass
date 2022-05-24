#!/bin/bash

#

case "${1}" in
  start)
	echo "Starting.."
	;;
  stop)
	echo "Stoping.."
	;;
  status | state)
	echo "Status:"
	;;
  *)
	echo "Not a valid input."
	;;
esac

