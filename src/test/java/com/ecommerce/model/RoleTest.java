package com.ecommerce.model;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class RoleTest {

    @Test
    public void testEnumValues() {
        assertEquals(Role.CLIENT, Role.valueOf("CLIENT"));
        assertEquals(Role.ADMIN, Role.valueOf("ADMIN"));
    }

    @Test
    public void testEnumCount() {
        assertEquals(2, Role.values().length);
    }
}
