package other;

import all.Common;
import org.junit.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.Dimension;


public class GithubTest extends Common {

    @Test
    public void header() {
        driver.get("https://github.com/");
        driver.manage().window().setSize(new Dimension(1653, 1050));
        driver.findElement(By.linkText("Contact Sales")).click();
        System.out.println(driver.getTitle());
    }
}