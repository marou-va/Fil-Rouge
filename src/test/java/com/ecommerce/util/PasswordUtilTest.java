package com.ecommerce.util;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class PasswordUtilTest {

    @Test
    public void testHashAndCheckPassword() {
        String original = "mypassword123";
        String hashed = PasswordUtil.hashPassword(original);
        
        assertNotNull(hashed);
        assertNotEquals(original, hashed);
        assertTrue(PasswordUtil.checkPassword(original, hashed));
    }

    @Test
    public void testWrongPassword() {
        String original = "mypassword123";
        String hashed = PasswordUtil.hashPassword(original);
        
        assertFalse(PasswordUtil.checkPassword("wrongpassword", hashed));
    }

    @Test
    public void testEmptyAndNull() {
        assertFalse(PasswordUtil.checkPassword("", "somehash"));
        assertFalse(PasswordUtil.checkPassword(null, "somehash"));
        assertFalse(PasswordUtil.checkPassword("pass", null));
        assertFalse(PasswordUtil.checkPassword(null, null));
    }
}
