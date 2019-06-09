module ApplicationHelper
  
  #ページごとの完全なタイトルを返す
  def full_title(page_title='')
    base_title="A-note シンプルで使いやすいクラウドメモ帳・ノートアプリ"
    if page_title.empty?
      base_title
    else
      page_title+" | "+base_title
    end
  end
  
end
