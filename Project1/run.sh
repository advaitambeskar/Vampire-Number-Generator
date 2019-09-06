#!/bin/bash

ipaddr=$(ipconfig getifaddr en0)

iex --name $1@$ipaddr --cookie somecookie -r lib/vampire.ex -r lib/supervisor.ex -r lib/reciever.ex