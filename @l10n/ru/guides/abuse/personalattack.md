# Личная нападка

Личная нападка — это оскорбление, переход на личности, случай кибербуллинга или любой другой вид нападок на участника беседы. Случаи обнаруженных личных нападок регистрируются в разделе `abuse`, и их атрибуту `type` присваивается значение `personal_attack`.

## Что не считается личной нападкой?

- Нападка на социальную группу

   - Если целью является этническая, религиозная или расовая группа, как это классифицируется как `bigotry` (разжигание ненависти).
   - Нападки на другие социальные группы могут не подпадать ни под одну из категорий или могут быть помечены как `contentious` (контент, который может вызвать споры).

- Нападка на вымышленного персонажа или общественного деятеля

   - Критика вымышленного персонажа или общественного деятеля не считается личной нападкой.
   - Нападка на человека, который в данный момент не участвует в разговоре. Она означает нападку на любого человека, который не является вторым лицом («ты») и не идентифицирован упоминанием, связанным с ником пользователя (например, @user12345). 
   - Негативное отношение, которое не направлено непосредственно на человека. Например, _your music is bad_ («твоя музыка плохая») — это не личная нападка.

## Пример

Запрос:

```json
{
  "language":"en",
  "content":"You are so stupid, nobody likes you here!",
  "settings": 
  {
    "snippets":true, "explain":true
  }
}
```

Ответ:

```json
{
	"text": "You are so stupid, nobody likes you here!",
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 17,
			"text": "You are so stupid",
			"type": "personal_attack",
			"severity": "medium",
			"explanation": "Calling someone unsatisfactory"
		},
		{
			"sentence_index": 0,
			"offset": 19,
			"length": 16,
			"text": "nobody likes you",
			"type": "personal_attack",
			"severity": "medium",
			"explanation": "Claim of universal dislike"
		}
	]
}
```

## Переопределение политики по умолчанию

Политику исключения третьих лиц по умолчанию можно изменить с помощью модуля `memory`.

### Обнаружение нападок на указанных лиц

Для обнаружения нападок на людей, указанных по именам, добавьте следующую настройку памяти:

```json
{
  "assign": [
    {
      "if": {
        "features": [
          {
            "index": 1,
            "value": "NOUN"
          },
          {
            "index": 14,
            "value": "NA"
          },
          {
            "index": 22,
            "value": "PERS"
          }
        ]
      },
      "then": {
        "features": [
          {
            "index": 33,
            "value": "DIPA"
          }
        ],
        "hypernym": 123887
      }
    }
  ]
}
```

Например:

```json
{
  "language": "en",
  "content": "John Smith sucks",
  "settings": 
  {
    "memory":
    {
      "assign": [
      {
        "if": {
          "features": [
            {
              "index": 1,
              "value": "NOUN"
            },
            {
              "index": 14,
              "value": "NA"
            },
            {
              "index": 22,
              "value": "PERS"
            }
          ]
        },
        "then": {
          "features": [
            {
              "index": 33,
              "value": "DIPA"
            }
          ],
          "hypernym": 123887
        }
      } ]
    }
  }
}
```

### Обнаружение нападок на всех третьих лиц

Для обнаружения нападок на всех третих лиц добавьте следующую настройку памяти:

```json
{
  "assign": [
    {
      "if": {
        "features": [
          {
            "index": 1,
            "value": "NOUN"
          },
          {
            "index": 9,
            "value": "3"
          },
          {
            "index": 22,
            "value": "PERS"
          }
        ]
      },
      "then": {
        "features": [
          {
            "index": 33,
            "value": "DIPA"
          }
        ],
        "hypernym": 123887
      }
    }
  ]
}
```

Например:

```json
{
  "language": "en",
  "content": "He is an idiot",
  "settings": 
  {
    "memory":
    {
      "assign": [
      {
        "if": {
          "features": [
            {
              "index": 1,
              "value": "NOUN"
            },
            {
              "index": 9,
              "value": "3"
            },
            {
              "index": 22,
              "value": "PERS"
            }
          ]
        },
        "then": {
          "features": [
            {
              "index": 33,
              "value": "DIPA"
            }
          ],
          "hypernym": 123887
        }
      } ]
    }
  }
}
```