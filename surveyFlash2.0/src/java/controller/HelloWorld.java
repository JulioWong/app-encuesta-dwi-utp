/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import javax.inject.Named;
import javax.enterprise.context.RequestScoped;
import javax.faces.context.FacesContext;

/**
 *
 * @author julio.wong
 */
@Named(value = "helloWorld")
@RequestScoped
public class HelloWorld {

    /**
     * Creates a new instance of HelloWorld
     */
    public HelloWorld() {
    }
    
    public void sayHello() throws IOException {
        FacesContext.getCurrentInstance().getExternalContext()
                        .redirect("./");
    }
    
}
