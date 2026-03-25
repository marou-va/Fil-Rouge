package com.ecommerce.service;

import java.util.List;

import com.ecommerce.dao.CategorieDAO;
import com.ecommerce.model.Categorie;

public class CategorieService {

    private final CategorieDAO categorieDAO;

    public CategorieService() {
        this(new CategorieDAO());
    }

    public CategorieService(CategorieDAO categorieDAO) {
        this.categorieDAO = categorieDAO;
    }

    public List<Categorie> getAllCategories() {
        return categorieDAO.getAllCategories();
    }

    public Categorie getCategorieById(Long id) {
        if (id == null) {
            return null;
        }
        return categorieDAO.getCategorieById(id);
    }

    public Categorie saveOrUpdate(String idStr, String nom, String description) {
        if (nom == null || nom.isBlank()) {
            throw new IllegalArgumentException("Le nom de la categorie est obligatoire.");
        }

        Categorie categorie = new Categorie();
        if (idStr != null && !idStr.isBlank()) {
            Long id = parseId(idStr, "Identifiant de categorie invalide.");
            categorie = categorieDAO.getCategorieById(id);
            if (categorie == null) {
                throw new IllegalArgumentException("Categorie introuvable.");
            }
        }

        categorie.setNom(nom.trim());
        categorie.setDescription(description == null ? null : description.trim());

        if (categorie.getId() == null) {
            categorieDAO.save(categorie);
        } else {
            categorieDAO.update(categorie);
        }
        return categorie;
    }

    public void delete(String idStr) {
        Long id = parseId(idStr, "Identifiant de categorie invalide.");
        categorieDAO.delete(id);
    }

    private Long parseId(String idStr, String message) {
        try {
            Long id = Long.parseLong(idStr);
            if (id <= 0) {
                throw new IllegalArgumentException(message);
            }
            return id;
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException(message);
        }
    }
}
