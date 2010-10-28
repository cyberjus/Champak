class ViewsController < ApplicationController
  
  def by_category
    @name = params[:name].tr('-', ' ').sub(' Coupons','')
    @title = "#{@name} Coupons"
    category = Category.find_by_name(@name)
    @coupon_items = Coupon.active.where("category_id = ?", category.id).includes(:business).order(sort_by).where(filter_town) .paginate(:page => params[:page], :per_page => 10)
    render 'coupon_list'
  end
  
  def by_town
    @name = params[:name].tr('-', ' ').sub(' Coupons','')
    @title = "#{@name} Coupons"
    @coupon_items = Coupon.active.joins(:business).where('businesses.town = ?', @name).order(sort_by).where(filter_category).paginate(:page => params[:page], :per_page => 10)
    render 'coupon_list'
  end
  
  def by_new
    @title = "New Coupons"
    @coupon_items = Coupon.active.where("coupons.created_at >= ?", Time.now.months_ago(1)).includes(:business).order(sort_by).where(filter_town).where(filter_category).paginate(:page => params[:page], :per_page => 10)
    render 'coupon_list'
  end
  
  def by_distance
    @zipcode = params[:zip]
    @distance = params[:distance] ? params[:distance] : 10
    if /\d{5}(?:-\d{4})?/.match(@zipcode)
      if Rails.env.production?
        params[:sort] ||= 'distance'
        @title = "Coupons within #{@distance} miles of #{@zipcode}"
        @coupon_items = Coupon.active.joins(:business).within(@distance, :origin => @zipcode).order(sort_by).where(filter_town).where(filter_category).paginate(:page => params[:page], :per_page => 10)
        render 'coupon_list'
      else 
        @title = "Coupons in #{@zipcode}"       
        @coupon_items = Coupon.active.joins(:business).where("businesses.zipcode = ?", @zipcode).order(sort_by).where(filter_town).where(filter_category).paginate(:page => params[:page], :per_page => 10)
        render 'coupon_list'
      end
    else 
      @title = "Coupons by Distance"
      @coupon_items = ""
      render 'invalid_zip'
    end
  end
  
  def by_hot
    @title = "Hot Coupons"
    params[:sort] ||= 'popular'
    sql = "SELECT coupons.*, businesses.name  FROM (SELECT coupons.* FROM coupons ORDER BY prints DESC LIMIT 10) as coupons JOIN businesses ON businesses.id = coupons.business_id WHERE coupons.valid_until >= CURRENT_DATE AND coupons.valid_from <= CURRENT_DATE "
    sql += " AND  businesses.town = '#{params[:filter_town].tr('-', ' ')}' " if filter_town 
    sql += " AND  category_id = '#{params[:filter_category]}' " if filter_category  
    sql += "ORDER BY #{sort_by}"
    @coupon_items = Coupon.paginate_by_sql(sql, :page => params[:page], :per_page => 10)
    render 'coupon_list'
  end
  
  def by_online_only
    @title = "Online Only Coupons"
    @coupon_items = Coupon.active.where("online_only = ?", true).includes(:business).order(sort_by).where(filter_town).where(filter_category).paginate(:page => params[:page], :per_page => 10) 
    render 'coupon_list'
  end
  
  def search 
    @title = "Search Coupons"
    @search = params[:s]
    if @search != ""
      @coupon_items = Coupon.active.joins(:business).where('UPPER(short_description) LIKE ? OR UPPER(businesses.name) LIKE ?', "%#{@search.upcase}%", "%#{@search.upcase}%").order(sort_by).paginate(:page => params[:page], :per_page => 10) 
    else 
      @coupon_items = ""
    end      
    render 'search_list'  
  end
  
  def coupon
    @coupon = Coupon.find(params[:id])
    @title = "#{@coupon.business.name} Coupon"
    @suggest_town = Coupon.active.where('coupons.id <> ?', @coupon.id).joins(:business).where('businesses.town = ?', @coupon.business.town).order("RANDOM()").first()
    @suggest_cat = Coupon.active.where('coupons.id <> ?', @coupon.id).includes(:business).joins(:category).where('categories.name = ?', @coupon.category.name).order("RANDOM()").first()
  end
  
  def print_coupon
    @coupon = Coupon.find(params[:id])
    @coupon.print
    @title = "Coupon Found at www.Champak.net"
    render :layout => 'print'
  end
  
  def tweet_link 
    @coupon = Coupon.find_by_id(params[:id])
    if @coupon 
      redirect_to "/#{url_escape(@coupon.business.name)}-Coupons/#{url_escape(@coupon.short_description)}/#{@coupon.id}/"
    else
      redirect_to root_path
    end
  end
  
  ## AJAX Actions
  
  def rate_coupon 
    coupon = Coupon.find_by_id(params[:id])
    rating = Float(params[:star_rating])
    if coupon && rating > 0
      coupon.rate(rating)
    end
    render :nothing => true 
  end
  
  private 
  
  def sort_by 
    sort = case params[:sort]
      when 'business' then 'businesses.name, short_description'
      when 'description' then 'short_description, businesses.name'
      when 'expiring' then 'valid_until, businesses.name, short_description'
      when 'popular' then 'prints DESC, businesses.name, short_description'
      when 'savings' then 'value DESC, businesses.name, short_description' 
      when 'newest' then 'coupons.created_at DESC, businesses.name, short_description'
      when 'distance' then 'distance, businesses.name, short_description '      
      else 'businesses.name, short_description'
    end 
  end
  
  def filter_town
    if params[:filter_town]
      @filter_town = params[:filter_town]
      return ["businesses.town = ?", params[:filter_town].tr('-', ' ')]
    end 
  end
  
  def filter_category
    if params[:filter_category]
      @filter_category = Category.find_by_id(params[:filter_category])
      return ["category_id = ?", params[:filter_category]]
    end 
  end
  
  def url_escape(url)
    URI.escape(url.sub('%',' percent').sub('/', '%25').tr(' ', '-'))
  end
  
end
