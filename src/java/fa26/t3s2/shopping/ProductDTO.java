/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package fa26.t3s2.shopping;

import java.io.Serializable;

/**
 *
 * @author jayke
 */
public class ProductDTO implements Serializable {

    private int pid;
    private String name;
    private double price;
    private int quantity;

    public ProductDTO() {
        this.pid=0;
        this.name="";
        this.price=0.0;
        this.quantity=0;
    }

    public ProductDTO(int pid, String name, double price, int quantity) {
        this.pid = pid;
        this.name = name;
        this.price = price;
        this.quantity = quantity;
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}
