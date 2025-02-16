#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
    // СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды

КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
    // СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды

КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	ПодключаемыеКомандыКлиент.ПослеЗаписи(ЭтотОбъект, Объект, ПараметрыЗаписи);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыТовары

&НаКлиенте
Процедура ТоварыКоличествоПриИзменении(Элемент)

	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;

	РассчитатьСуммуСтроки(ТекущиеДанные);

КонецПроцедуры

&НаКлиенте
Процедура ТоварыЦенаПриИзменении(Элемент)

	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;

	РассчитатьСуммуСтроки(ТекущиеДанные);

КонецПроцедуры

&НаКлиенте
Процедура ТоварыСкидкаПриИзменении(Элемент)

	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;

	РассчитатьСуммуСтроки(ТекущиеДанные);

КонецПроцедуры

&НаКлиенте
Процедура ТоварыПриИзменении(Элемент)

	РассчитатьСуммуДокумента();

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыУслуги

&НаКлиенте
Процедура УслугиКоличествоПриИзменении(Элемент)

	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;

	РассчитатьСуммуСтроки(ТекущиеДанные);

КонецПроцедуры

&НаКлиенте
Процедура УслугиЦенаПриИзменении(Элемент)

	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;

	РассчитатьСуммуСтроки(ТекущиеДанные);

КонецПроцедуры

&НаКлиенте
Процедура УслугиСкидкаПриИзменении(Элемент)

	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;

	РассчитатьСуммуСтроки(ТекущиеДанные);

КонецПроцедуры

&НаКлиенте
Процедура УслугиПриИзменении(Элемент)

	РассчитатьСуммуДокумента();

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура РассчитатьСуммуСтроки(ТекущиеДанные)
	//++ДП Замена кода рассчета суммы
	//КоэффициентСкидки = 1 - ТекущиеДанные.Скидка / 100;
	//ТекущиеДанные.Сумма = ТекущиеДанные.Цена * ТекущиеДанные.Количество * КоэффициентСкидки;
	//  
	ДП_ПересчитатьКолонкуСумма(ТекущиеДанные);
	//--
	РассчитатьСуммуДокумента();
КонецПроцедуры

&НаКлиенте
Процедура РассчитатьСуммуДокумента()

	Объект.СуммаДокумента = Объект.Товары.Итог("Сумма") + Объект.Услуги.Итог("Сумма");

КонецПроцедуры
#Область Доработки

&НаКлиенте
Процедура ДП_ПересчитатьКолонкуСумма(Строка)

	КоэффициентСкидки = 1 - (Строка.Скидка + Объект.ДП_СогласованнаяСкидка) / 100;
	Если КоэффициентСкидки > 0 Тогда
		Строка.Сумма = Строка.Цена * Строка.Количество * КоэффициентСкидки;
	Иначе
		Строка.Сумма = 0;
	КонецЕсли;
	
КонецПроцедуры
&НаКлиенте
Процедура ДП_СогласованнаяСкидкаПриИзменении(Элемент)

	Если НетДанныхВТаблицах() Тогда
		Возврат;
	КонецЕсли;

	Оповещение = Новый ОписаниеОповещения("ДП_ПослеОтветаНаВопрос", ЭтотОбъект);
	ПоказатьВопрос(Оповещение, "Изменился процент скидки. Пересчитать табличную часть?", РежимДиалогаВопрос.ДаНет);

КонецПроцедуры

&НаКлиенте
Функция НетДанныхВТаблицах()

	Возврат Объект.Товары.Количество() = 0 И Объект.Услуги.Количество() = 0;

КонецФункции

&НаКлиенте
Процедура ДП_ПослеОтветаНаВопрос(Результат, ДополнительныеПараметры) Экспорт

	Если Результат = КодВозвратаДиалога.Нет Тогда
		Возврат;
	КонецЕсли;

	ДП_РассчитатьСуммуСтрок();

КонецПроцедуры

&НаКлиенте
Процедура КомандаПересчитатьТаблицу(Команда)

	Если НетДанныхВТаблицах() Или Не ЗначениеЗаполнено(Объект.ДП_СогласованнаяСкидка) Тогда
		Возврат;
	КонецЕсли;

	ДП_РассчитатьСуммуСтрок();

КонецПроцедуры

&НаКлиенте
Процедура ДП_РассчитатьСуммуСтрок()

	Для Каждого Строка Из Объект.Товары Цикл
		ДП_ПересчитатьКолонкуСумма(Строка);
	КонецЦикла;

	Для Каждого Строка Из Объект.Услуги Цикл
		ДП_ПересчитатьКолонкуСумма(Строка);
	КонецЦикла;

	РассчитатьСуммуДокумента();

КонецПроцедуры

#КонецОбласти

#Область ПодключаемыеКоманды

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	ПодключаемыеКомандыКлиент.НачатьВыполнениеКоманды(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПродолжитьВыполнениеКомандыНаСервере(ПараметрыВыполнения, ДополнительныеПараметры) Экспорт
	ВыполнитьКомандуНаСервере(ПараметрыВыполнения);
КонецПроцедуры

&НаСервере
Процедура ВыполнитьКомандуНаСервере(ПараметрыВыполнения)
	ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, ПараметрыВыполнения, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

#КонецОбласти

#КонецОбласти