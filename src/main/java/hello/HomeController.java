package hello;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@EnableAutoConfiguration
public class HomeController {

    @GetMapping("/")
    @ResponseBody
    public String welcome() {
        return "Hello";
    }

    public static void main(String[] args) {
        SpringApplication.run(HomeController.class, args);
    }


}