package pages;

import com.codeborne.selenide.Condition;
import com.codeborne.selenide.SelenideElement;
import com.codeborne.selenide.WebDriverRunner;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.FindBy;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

/**
 * Created by hirofumi on 2015/12/15.
 */
public class ITproPage {
    @FindBy(css="img[alt='小江戸らぐ']")
    private SelenideElement 小江戸らぐ小型写真;

    @FindBy(css="img[src='koedlug.jpg']")
    private SelenideElement 小江戸らぐ大型写真;

    @FindBy(css="img[src='/images/n/itpro/2010/leaf/btn_pc.gif']")
    private SelenideElement PC版を読むボタン;

    @FindBy(linkText = "このページをスキップする")
    private SelenideElement このページをスキップする;

    private String currentWinHandle;

    public ITproPage PC版ページへ() {
        //$("img[src='/images/n/itpro/2010/leaf/btn_pc.gif']").click();
        PC版を読むボタン.click();
        return this;
    }

    public ITproPage このページをスキップ(String ブラウザ) {
        if (ブラウザ.startsWith("Android "))
            //if (!$("img[alt='小江戸らぐ']").exists()) {
        {
            if (!小江戸らぐ小型写真.exists()) {
                //$("img[src='/images/n/itpro/2010/leaf/btn_pc.gif']").should(Condition.appear);
                //$("img[src='/images/n/itpro/2010/leaf/btn_pc.gif']").should(Condition.enabled);
                PC版を読むボタン.should(Condition.appear);
                PC版を読むボタン.should(Condition.enabled);
                PC版ページへ();
            }
        }

        //if (!$("img[alt='小江戸らぐ']").exists()) {
        if (!小江戸らぐ小型写真.exists()) {
        //if ((!小江戸らぐ小型写真.exists()) && (このページをスキップする.exists())) {
            /*
            $(By.linkText("このページをスキップする")).should(Condition.appear);
            $(By.linkText("このページをスキップする")).should(Condition.enabled);
            $(By.linkText("このページをスキップする")).click();
            */
            このページをスキップする.should(Condition.appear);
            このページをスキップする.should(Condition.enabled);
            このページをスキップする.click();
        }
        //$("img[alt='小江戸らぐ']").should(Condition.exist);
        小江戸らぐ小型写真.should(Condition.exist);
        return this;
    }

    public ITproPage 写真の表示待ち(String ブラウザ) {
        このページをスキップ(ブラウザ);
        //$("img[alt='小江戸らぐ']").should(Condition.enabled);
        小江戸らぐ小型写真.should(Condition.enabled);
        return this;
    }

    public ITproPage 写真をクリック(String ブラウザ) {
        写真の表示待ち(ブラウザ);
        //$("img[alt='小江戸らぐ']").click();

        WebDriver driver = WebDriverRunner.getWebDriver();

        Set<String> windowHandles = driver.getWindowHandles();
        int number = windowHandles.size();

        小江戸らぐ小型写真.click();
        this.currentWinHandle = driver.getWindowHandle();
        while (driver.getWindowHandles().size() == number) {

        };
        for (String winHandle : driver.getWindowHandles()) {
            if (!windowHandles.contains(winHandle))
              driver.switchTo().window(winHandle); // switch focus of WebDriver to the next found window handle (that's your newly opened window)
        }

        小江戸らぐ大型写真.should(Condition.enabled);

        return this;
    }

    public void close() {
        WebDriver driver = WebDriverRunner.getWebDriver();

        driver.close();

        driver.switchTo().window(this.currentWinHandle);

        driver.quit();

    }
}
