# テーブル設計

## users テーブル

| Column               | Type    | Options     |
| -------------------- | ------- | ----------- |
| nickname             | string  | null: false |
| email                | string  | null: false |
| encrypted_password   | string  | null: false |
| last_name            | string  | null: false |
| first_name           | string  | null: false |
| last_name_kana       | string  | null: false |
| first_name_kana      | string  | null: false |
| birth_date_year      | integer | null: false |
| birth_date_month     | integer | null: false |
| birth_date_day       | integer | null: false |

### Association

- has_many :items
- has_many :orders



## items テーブル

| Column               | Type          | Options                        |
| -------------------- | ------------- | ------------------------------ |
| image                | ActiveStorage |                                |
| name                 | string        | null: false                    |
| info                 | text          | null: false                    |
| category             | string        | null: false                    |
| status               | string        | null: false                    |
| shipping_fee         | string        | null: false                    |
| prefecture           | string        | null: false                    |
| scheduled_delivery   | string        | null: false                    |
| price                | integer       | null: false,                   |
| user_id              | references    | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :order



## orders テーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| card_number         | integer    | null: false                    |
| card_expiry_month   | integer    | null: false                    |
| card_expiry_year    | integer    | null: false                    |
| card_cvc            | integer    | null: false                    |
| postal_code         | integer    | null: false                    |
| prefecture          | string     | null: false                    |
| city                | string     | null: false                    |
| address             | string     | null: false                    |
| building_name       | string     |                                |
| phone_number        | integer    | null: false                    |
| user_id             | references | null: false, foreign_key: true |
| item_id             | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
