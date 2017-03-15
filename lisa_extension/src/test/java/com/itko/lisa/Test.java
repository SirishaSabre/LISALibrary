package com.itko.lisa;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by SG0222123 on 11/20/2016.
 */
public class Test {
    public static void main (String[] args) throws Exception {
        String str= "UNB+IATA:1+1P+AZ+{{currentdate.yyMMddHHmm}}+B1E898'\n" +
                "UNH+1+ITAREQ:96:2:IA+B1E898100150017'\n" +
                "MSG+:60::730'\n" +
                "ORG+1P:HDQ+38262475:EEA+MIL+1P+T+IT:EUR+GS'\n" +
                "ODI+MUC+NAP'\n" +
                "TVL+291116:1200:291116:1340+MUC+FCO+AZ+0437:B+++P'\n" +
                "RPI+1+NN'\n" +
                "TVL+291116:1425:291116:1520+FCO+NAP+AZ+1269:B+++P'\n" +
                "RPI+1+NN'\n" +
                "UNT+9+1'\n" +
                "UNZ+1+B1E898'";
        System.out.println(str.replace("\n", ""));
        SimpleDateFormat dateFormat = new SimpleDateFormat("MMddyyHHmmss");
        String date=dateFormat.format(new Date());
        System.out.println(date);
    }
}
