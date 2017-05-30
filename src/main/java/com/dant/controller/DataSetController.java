package com.dant.controller;

import com.dant.business.*;

import javax.ws.rs.*;

/**
 * Created by 3502804 on 29/05/17.
 */

@Path("/api/dataset")
public class DataSetController {

    @POST
    public String init () {
        return UtilBusiness.createDataSet();
    }
}
