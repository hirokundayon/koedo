package pages;

/**
 * Created by hirofumi on 2015/12/15.
 */

import com.codeborne.selenide.SelenideElement;
import org.openqa.selenium.support.FindBy;

import static com.codeborne.selenide.Selenide.page;

public class GoogleResultPage {
    //@FindBy(linkText = "小江戸らぐ - 川越を中心にゆるく活動するLinuxユーザー会 - ITpro")
    @FindBy(css ="a[href='http://itpro.nikkeibp.co.jp/article/COLUMN/20131003/508665/']")
    private SelenideElement リンク;

    public ITproPage リンクをクリック() {
        //$(By.linkText("小江戸らぐ - 川越を中心にゆるく活動するLinuxユーザー会 - ITpro")).click();
        リンク.click();
        return page(ITproPage.class);
    }

}
