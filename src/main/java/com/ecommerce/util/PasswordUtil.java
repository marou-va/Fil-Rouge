package com.ecommerce.util;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {

    /**
     * Hache le mot de passe en utilisant BCrypt.
     * 
     * @param plainTextPassword Le mot de passe en clair.
     * @return Le hachage du mot de passe.
     */
    public static String hashPassword(String plainTextPassword) {
        return BCrypt.hashpw(plainTextPassword, BCrypt.gensalt(12));
    }

    /**
     * Vérifie si le mot de passe en clair correspond au hachage.
     * 
     * @param plainTextPassword Le mot de passe en clair.
     * @param hashedPassword    Le mot de passe haché stocké.
     * @return true si ça correspond, false sinon.
     */
    public static boolean checkPassword(String plainTextPassword, String hashedPassword) {
        try {
            return BCrypt.checkpw(plainTextPassword, hashedPassword);
        } catch (Exception e) {
            return false;
        }
    }
}
