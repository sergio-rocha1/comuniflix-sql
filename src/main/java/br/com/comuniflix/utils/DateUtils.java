package br.com.comuniflix.utils;

import java.sql.Date;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeFormatterBuilder;
import java.util.Locale;

public abstract class DateUtils {

    private static final String FORMATO_DATA_PADRAO = "dd/MM/yyyy";

    public static Date formatarParaBD(LocalDate data) {
        return Date.valueOf(data);
    }

    public static String formatarParaAplicacao(Date date) {
        return formatarParaExibicao(date.toLocalDate());
    }

    private static String formatarParaExibicao(LocalDate date) {
        DateTimeFormatter formatter = new DateTimeFormatterBuilder()
                .parseCaseInsensitive()
                .appendPattern(FORMATO_DATA_PADRAO)
                .toFormatter(Locale.forLanguageTag("pt-BR"));
        return date.format(formatter);
    }
}
