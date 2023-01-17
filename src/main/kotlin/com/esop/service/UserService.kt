package com.esop.service

import io.micronaut.json.tree.JsonNode
import java.util.regex.Pattern

val all_firstname= mutableSetOf<String>()
val all_lastname= mutableSetOf<String>()
val all_emails= mutableSetOf<String>()
val all_numbers= mutableSetOf<String>()
val all_usernames= mutableSetOf<String>()

fun check_username(username_set: MutableSet<String>, search_value: String) : Boolean
{
    return username_set.contains(search_value);
}

fun check_phonenumber(usernumber_set: MutableSet<String>,search_value:String) : Boolean
{
    return usernumber_set.contains(search_value);
}

fun check_email(useremail_set: MutableSet<String>, search_value: String) : Boolean
{
    return useremail_set.contains(search_value);
}

const val REG = "^(\\+91[\\-\\s]?)?[0]?(91)?[789]\\d{9}\$"
var PATTERN: Pattern = Pattern.compile(REG)
fun CharSequence.isPhoneNumber() : Boolean = PATTERN.matcher(this).find()

val EMAIL_REGEX = "^[A-Za-z](.*)([@]{1})(.{1,})(\\.)(.{1,})";

fun isEmailValid(email: String): Boolean {
    return EMAIL_REGEX.toRegex().matches(email);
}

class UserService {


}