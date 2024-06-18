#!/bin/bash

# Cek jumlah argumen
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <unique_string> <username>"
    exit 1
fi
unique_string="$1"
username="$2"
authorized_keys_file="/home/$username/.ssh/authorized_keys"
# Cek apakah pengguna ada
getent passwd "$username" >/dev/null
if [ $? -ne 0 ]; then
    echo "Error: User '$username' not found."
    exit 1
fi
# Mencari dan menghapus kunci publik yang mengandung string unik
temp_file=$(mktemp)
grep -v "$unique_string" "$authorized_keys_file" > "$temp_file"
mv "$temp_file" "$authorized_keys_file"
echo "Public key containing '$unique_string' removed from $authorized_keys_file for user $username."
