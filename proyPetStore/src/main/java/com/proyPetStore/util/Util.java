package com.proyPetStore.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class Util {

    /**
     * Encripta una cadena usando el algoritmo MD5.
     * 
     * @param input La cadena a encriptar.
     * @return La cadena encriptada en formato hexadecimal, o null si hay error.
     */
    public static String encriptarMD5(String input) {
        if (input == null || input.isEmpty()) {
            return null;
        }
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] messageDigest = md.digest(input.getBytes());
            StringBuilder hexString = new StringBuilder();
            for (byte b : messageDigest) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1)
                    hexString.append('0');
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
    }
}
