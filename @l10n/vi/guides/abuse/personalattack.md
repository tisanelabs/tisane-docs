# Tấn công cá nhân

Tấn công cá nhân là hành vi xúc phạm, công kích mang tính cá nhân, bắt nạt trên mạng hoặc bất kỳ hình thức công kích nào nhắm vào người tham gia trò chuyện. Các trường hợp tấn công cá nhân được phát hiện sẽ được ghi nhận trong mục `abuse`, với thuộc tính `type` được đặt là `personal_attack`.

## Những gì không được xem là tấn công cá nhân?

- Tấn công một nhóm xã hội

   - Nếu mục tiêu là một nhóm dân tộc, tôn giáo hoặc chủng tộc, thì hành vi này được phân loại là `bigotry` (ngôn từ thù ghét).
   - Tấn công các nhóm xã hội khác có thể không thuộc bất kỳ danh mục nào, hoặc có thể được đánh dấu là `contentious` (nội dung dễ gây tranh cãi).

- Tấn công nhân vật hư cấu hoặc người của công chúng

   - Chỉ trích một nhân vật hư cấu hoặc người nổi tiếng không được xem là tấn công cá nhân.
   - Tấn công người không tham gia vào cuộc trò chuyện hiện tại. Tức là bất kỳ ai không phải là người được xưng hô trực tiếp (ngôi thứ hai – “bạn”) và không được nhắc đến qua tên người dùng có gắn thẻ (ví dụ: @user12345). 
   - Thái độ tiêu cực nhưng không nhắm trực tiếp vào con người. Ví dụ, câu _"your music is bad"_ (nhạc của bạn dở quá) không được xem là tấn công cá nhân.

## Ví dụ

Yêu cầu:

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

Phản hồi:

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

## Điều chỉnh chính sách mặc định

Chính sách mặc định loại trừ các bên thứ ba, nhưng bạn có thể thay đổi bằng cách sử dụng mô-đun `memory` (bộ nhớ).

### Phát hiện tấn công vào bên được nhắc tên

Để phát hiện các cuộc tấn công nhắm vào người được gọi tên, hãy thêm thiết lập sau vào bộ nhớ:

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

Ví dụ:

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

### Phát hiện tấn công nhắm vào mọi bên thứ ba

Để phát hiện tấn công nhắm vào mọi bên thứ ba, hãy thêm thiết lập sau vào bộ nhớ:

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

Ví dụ:

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