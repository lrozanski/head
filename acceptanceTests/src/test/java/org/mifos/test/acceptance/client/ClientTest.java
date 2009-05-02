/*
 * Copyright (c) 2005-2009 Grameen Foundation USA
 * All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
 * implied. See the License for the specific language governing
 * permissions and limitations under the License.
 *
 * See also http://www.apache.org/licenses/LICENSE-2.0.html for an
 * explanation of the license and how it is applied.
 */
 
package org.mifos.test.acceptance.client;

import org.mifos.test.acceptance.framework.AppLauncher;
import org.mifos.test.acceptance.framework.HomePage;
import org.mifos.test.acceptance.framework.MifosPage;
import org.mifos.test.acceptance.framework.UiTestCaseBase;
import org.mifos.test.acceptance.framework.ClientsAndAccountsHomepage;
import org.mifos.test.acceptance.framework.admin.AdminPage;
import org.mifos.test.acceptance.framework.client.ClientViewDetailsPage;
import org.mifos.test.acceptance.framework.user.CreateUserEnterDataPage;
import org.mifos.test.acceptance.framework.user.UserViewDetailsPage;
import org.mifos.test.acceptance.util.StringUtil;
import org.springframework.test.context.ContextConfiguration;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

@ContextConfiguration(locations = { "classpath:ui-test-context.xml" })
@Test(sequential = true, groups = {"smoke","client","acceptance","ui"})

public class ClientTest extends UiTestCaseBase {

    private AppLauncher appLauncher;

    @SuppressWarnings("PMD.SignatureDeclareThrowsException")
    // one of the dependent methods throws Exception
    @BeforeMethod
    public void setUp() throws Exception {
        super.setUp();
        appLauncher = new AppLauncher(selenium);
    }

    @AfterMethod
    public void logOut() {
        (new MifosPage(selenium)).logout();
    }

    public void createClientAndChangeStatusTest() {
        HomePage homePage = appLauncher.launchMifos().loginSuccessfullyUsingDefaultCredentials();
        AdminPage adminPage = homePage.navigateToAdminPage();

        String officeName = "Bangalore Branch " + StringUtil.getRandomString(8);
        AdminPage adminPage2 = adminPage.createOffice(adminPage, officeName);

        CreateUserEnterDataPage.SubmitFormParameters userParameters = adminPage2.getAdminUserParameters();
        UserViewDetailsPage userDetailsPage = adminPage.createUser(adminPage2, userParameters, officeName);

        ClientsAndAccountsHomepage clientsAndAccountsPage = userDetailsPage.navigateToClientsAndAccountsHomepage();
        String loanOfficer = userParameters.getFirstName() + " " + userParameters.getLastName();
        ClientViewDetailsPage clientDetailsPage = clientsAndAccountsPage.createClient(loanOfficer, officeName);
        
        clientsAndAccountsPage.changeCustomerStatus(clientDetailsPage);
    }
}
