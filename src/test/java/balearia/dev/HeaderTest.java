
package balearia.dev;

import all.Common;
import org.junit.Test;
import org.openqa.selenium.*;


public class HeaderTest extends Common {

    @Test
    public void header() {
        driver.get("http://192.168.212.16:8080/es/reservar");
        driver.manage().window().setSize(new Dimension(1653, 1050));
        driver.navigate().refresh();
        driver.findElement(By.cssSelector("#layout_116 span")).click();
        driver.findElement(By.cssSelector("#layout_220 span")).click();
        driver.findElement(By.cssSelector("#layout_100 span")).click();
        driver.findElement(By.linkText("Información")).click();
        driver.findElement(By.cssSelector("#layout_26 span")).click();
        driver.findElement(By.cssSelector(".logo > img")).click();
        driver.findElement(By.id("check-availability-portlet-autocomplete-autocompleteContent")).click();
        driver.findElement(By.id("check-availability-portlet-autocomplete-autocompleteContent")).sendKeys("hola");
        driver.findElement(By.id("check-availability-portlet-autocomplete-autocompleteContent")).sendKeys(Keys.ENTER);

        System.out.println(driver.getTitle());
    }
}


