
package formulari;

import org.junit.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.Dimension;

import all.Common;

public class BasicTest extends Common {

    @Test
    public void aixoesunaprova() {
        driver.get("http://localhost:8080/index.html");
        driver.manage().window().setSize(new Dimension(1936, 1066));
        driver.findElement(By.id("name")).click();
        driver.findElement(By.id("name")).sendKeys("Hola");
        driver.findElement(By.id("mail")).sendKeys("thisIsATest@gmail");
        driver.findElement(By.id("msg")).click();
        driver.findElement(By.id("msg")).sendKeys("Lorem ipsum dolor sit amet, consectetur adipiscing " +
                "elit. Sed sagittis faucibus leo, vitae fringilla erat semper eu. Aenean iaculis massa sit amet ipsum " +
                "aliquam fermentum. Aliquam pulvinar nibh vel dignissim auctor. Aenean at ornare ipsum. Morbi commodo " +
                "facilisis odio ut aliquet. Nunc vitae ante lectus. Cras pretium eros in neque dapibus, id pharetra " +
                "turpis interdum. Nullam sed viverra nisi, vel cursus purus. Aenean ullamcorper ac odio eu dignissim. " +
                "Donec non justo nec nisi vulputate vehicula. Pellentesque purus purus, pharetra ac tincidunt vitae, " +
                "accumsan eu lacus. Integer a urna sit amet diam scelerisque tempor. Fusce eget sapien sit amet lacus " +
                "laoreet tincidunt.");
        driver.findElement(By.cssSelector("button")).click();

        System.out.println(driver.getTitle());

    }
}


