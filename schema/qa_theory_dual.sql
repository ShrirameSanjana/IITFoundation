-- Dual theory JSON storage (theory_dual_v1 schema from *_theory.json).
-- Separate from legacy qa_theory_chapter (flat topic sections for qa_table).
--
-- Run: mysql -u user -p foundation < schema/qa_theory_dual.sql

CREATE TABLE IF NOT EXISTS qa_theory_dual_book (
  book_slug VARCHAR(255) NOT NULL,
  book_name VARCHAR(512) NOT NULL DEFAULT '',
  class_num VARCHAR(16) NOT NULL DEFAULT '',
  subject VARCHAR(64) NOT NULL DEFAULT '',
  schema_version VARCHAR(64) NOT NULL DEFAULT 'theory_dual_v1',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (book_slug)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS qa_theory_dual_chapter (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  book_slug VARCHAR(255) NOT NULL,
  chapter_key VARCHAR(64) NOT NULL,
  chapter_number INT NOT NULL DEFAULT 0,
  chapter_name VARCHAR(512) NOT NULL DEFAULT '',
  chapter_payload LONGTEXT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_book_chapter_key (book_slug, chapter_key),
  KEY idx_book_number (book_slug, chapter_number),
  CONSTRAINT fk_theory_dual_book
    FOREIGN KEY (book_slug) REFERENCES qa_theory_dual_book (book_slug)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
