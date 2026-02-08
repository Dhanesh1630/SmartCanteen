package com.model;

public class MenuItem {

    private int itemId;
    private String itemName;
    private double price;
    private String category;
    private String available;

    public MenuItem() {}

    public MenuItem(int itemId, String itemName, double price, String category, String available) {
        this.itemId = itemId;
        this.itemName = itemName;
        this.price = price;
        this.category = category;
        this.available = available;
    }

    public int getItemId() {
        return itemId;
    }

    public void setItemId(int itemId) {
        this.itemId = itemId;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getAvailable() {
        return available;
    }

    public void setAvailable(String available) {
        this.available = available;
    }
}
