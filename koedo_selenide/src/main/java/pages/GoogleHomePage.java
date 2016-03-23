package pages;

/**
 * Created by hirofumi on 2015/12/15.
 */

import com.codeborne.selenide.Selenide;
import com.codeborne.selenide.SelenideElement;

public class GoogleHomePage {
    private SelenideElement q;

    public GoogleResultPage 検索(String text) {
        q.val(text).pressEnter();
        return Selenide.page(GoogleResultPage.class);
    }
}
