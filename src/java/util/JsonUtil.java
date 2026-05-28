package util;

public class JsonUtil {

    public static String escaparJson(String texto) {
        if (texto == null) {
            return "";
        }
        return texto.replace("\\", "\\\\")
                    .replace("\"", "\\\"")
                    .replace("\n", "\\n")
                    .replace("\r", "\\r");
    }

    public static String extrairCampoString(String json, String campo) {
        String chave = "\"" + campo + "\":\"";
        int inicio = json.indexOf(chave);
        if (inicio == -1) {
            return "";
        }
        inicio += chave.length();
        int fim = json.indexOf("\"", inicio);
        if (fim == -1) {
            return "";
        }
        return json.substring(inicio, fim);
    }

    public static double extrairCampoDouble(String json, String campo) {
        String chave = "\"" + campo + "\":";
        int inicio = json.indexOf(chave);
        if (inicio == -1) {
            return 0.0;
        }
        inicio += chave.length();
        int fim = inicio;
        while (fim < json.length()) {
            char c = json.charAt(fim);
            if (c == ',' || c == '}' || c == ']') {
                break;
            }
            fim++;
        }
        String valor = json.substring(inicio, fim).trim();
        try {
            return Double.parseDouble(valor);
        } catch (NumberFormatException e) {
            return 0.0;
        }
    }

    public static int extrairCampoInt(String json, String campo) {
        String chave = "\"" + campo + "\":";
        int inicio = json.indexOf(chave);
        if (inicio == -1) {
            return 0;
        }
        inicio += chave.length();
        int fim = inicio;
        while (fim < json.length()) {
            char c = json.charAt(fim);
            if (c == ',' || c == '}' || c == ']') {
                break;
            }
            fim++;
        }
        String valor = json.substring(inicio, fim).trim();
        try {
            return Integer.parseInt(valor);
        } catch (NumberFormatException e) {
            return 0;
        }
    }
}
