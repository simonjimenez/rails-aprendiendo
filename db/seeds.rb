require 'open-uri'

# Limpia la base de datos en el orden correcto para evitar conflictos de claves foráneas
Product.destroy_all
Store.destroy_all
Category.destroy_all
User.destroy_all

# Creación de usuarios
usuarios = [
  { email: 'pedro@gmail.com', password: 'password' },
  { email: 'maria@gmail.com', password: 'password' },
  { email: 'juan@gmail.com', password: 'password' },
  { email: 'luisa@gmail.com', password: 'password' }
]

usuarios_creados = usuarios.map do |usuario|
  User.create!(usuario)
end

# Función para cargar imágenes
def attach_photo(record, url)
  retries = 3
  begin
    file = URI.open(url)
    record.photo.attach(io: file, filename: File.basename(url))
  rescue OpenURI::HTTPError => e
    retries -= 1
    if retries > 0
      sleep(1)
      retry
    else
      puts "No se pudo descargar la imagen de #{url}: #{e.message}"
    end
  end
end

# Datos de tiendas de comida rápida
stores_data = [
  {
    name: 'Burger King',
    categories: ['Hamburguesas', 'Bebidas', 'Postres'],
    products: [
      { name: 'Whopper', price: '80', description: 'Hamburguesa clásica de Burger King', image_url: 'https://www.burgerking.es/estaticos/img/products/whopper.png' },
      { name: 'Papas fritas', price: '40', description: 'Papas fritas crujientes', image_url: 'https://www.burgerking.es/estaticos/img/products/patatas.png' },
      { name: 'Sundae de chocolate', price: '30', description: 'Postre helado con salsa de chocolate', image_url: 'https://www.burgerking.es/estaticos/img/products/sundae_chocolate.png' },
      { name: 'Sundae de caramelo', price: '30', description: 'Postre helado con salsa de caramelo', image_url: 'https://www.burgerking.es/estaticos/img/products/sundae_caramelo.png' },
      { name: 'Nuggets de pollo', price: '50', description: 'Piezas de pollo empanizadas', image_url: 'https://www.burgerking.es/estaticos/img/products/nuggets.png' },
      { name: 'Ensalada César', price: '60', description: 'Ensalada fresca con aderezo César', image_url: 'https://www.burgerking.es/estaticos/img/products/ensalada_cesar.png' },
      { name: 'Batido de vainilla', price: '35', description: 'Batido cremoso de vainilla', image_url: 'https://www.burgerking.es/estaticos/img/products/batido_vainilla.png' },
      { name: 'Batido de fresa', price: '35', description: 'Batido cremoso de fresa', image_url: 'https://www.burgerking.es/estaticos/img/products/batido_fresa.png' },
      { name: 'Café americano', price: '25', description: 'Café negro recién hecho', image_url: 'https://www.burgerking.es/estaticos/img/products/cafe.png' }
    ],
    store_image: 'https://upload.wikimedia.org/wikipedia/commons/a/a7/Burger_King_Logo.svg'
  },
  {
    name: 'McDonald\'s',
    categories: ['Hamburguesas', 'Bebidas', 'Postres'],
    products: [
      { name: 'Big Mac', price: '85', description: 'Hamburguesa icónica de McDonald\'s', image_url: 'https://www.mcdonalds.es/sites/default/files/styles/product_thumbnail/public/productos/big-mac.png' },
      { name: 'McFlurry Oreo', price: '35', description: 'Helado con galletas Oreo', image_url: 'https://www.mcdonalds.es/sites/default/files/styles/product_thumbnail/public/productos/mcflurry-oreo.png' },
      { name: 'McNuggets', price: '50', description: 'Piezas de pollo crujientes', image_url: 'https://www.mcdonalds.es/sites/default/files/styles/product_thumbnail/public/productos/mcnuggets.png' },
      { name: 'Cuarto de Libra', price: '80', description: 'Hamburguesa con carne de 113g', image_url: 'https://www.mcdonalds.es/sites/default/files/styles/product_thumbnail/public/productos/cuarto-de-libra.png' },
      { name: 'McPollo', price: '75', description: 'Hamburguesa de pollo', image_url: 'https://www.mcdonalds.es/sites/default/files/styles/product_thumbnail/public/productos/mcpollo.png' },
      { name: 'Filete de pescado', price: '70', description: 'Hamburguesa de pescado', image_url: 'https://www.mcdonalds.es/sites/default/files/styles/product_thumbnail/public/productos/filete-de-pescado.png' },
      { name: 'Ensalada Mediterránea', price: '60', description: 'Ensalada fresca con ingredientes mediterráneos', image_url: 'https://www.mcdonalds.es/sites/default/files/styles/product_thumbnail/public/productos/ensalada-mediterranea.png' },
      { name: 'Batido de chocolate', price: '35', description: 'Batido cremoso de chocolate', image_url: 'https://www.mcdonalds.es/sites/default/files/styles/product_thumbnail/public/productos/batido-chocolate.png' },
      { name: 'Café con leche', price: '25', description: 'Café con leche recién hecho', image_url: 'https://www.mcdonalds.es/sites/default/files/styles/product_thumbnail/public/productos/cafe-con-leche.png' }
    ],
    store_image: 'https://upload.wikimedia.org/wikipedia/commons/6/6c/McDonald%27s_Logo.svg'
  },
  {
    name: 'KFC',
    categories: ['Pollo', 'Complementos', 'Bebidas'],
    products: [
      { name: 'Pollo Frito', price: '90', description: 'Pollo frito crujiente', image_url: 'https://www.kfc.es/assets/images/productos/pollo-frito.png' },
      { name: 'Puré de papa', price: '35', description: 'Puré de papa con gravy', image_url: 'https://www.kfc.es/assets/images/productos/pure-papa.png' },
      { name: 'Bisquets', price: '25', description: 'Panecillos tradicionales', image_url: 'https://www.kfc.es/assets/images/productos/bisquets.png' },
      { name: 'Alitas BBQ', price: '60', description: 'Alitas bañadas en salsa BBQ', image_url: 'https://www.kfc.es/assets/images/productos/alitas-bbq.png' },
      { name: 'Tiras de pollo', price: '50', description: 'Tiras de pollo empanizadas', image_url: 'https://www.kfc.es/assets/images/productos/tiras-pollo.png' },
      { name: 'Ensalada César', price: '60', description: 'Ensalada fresca con aderezo César', image_url: 'https://www.kfc.es/assets/images/productos/ensalada-cesar.png' },
      { name: 'Refresco mediano', price: '30', description: 'Refresco mediano a elegir', image_url: 'https://www.kfc.es/assets/images/productos/refresco.png' },
      { name: 'Batido de vainilla', price: '40', description: 'Batido cremoso de vainilla', image_url: 'https://www.kfc.es/assets/images/productos/batido-vainilla.png' },
      { name: 'Café americano', price: '25', description: 'Café negro recién hecho', image_url: 'https://www.kfc.es/assets/images/productos/cafe.png' }
    ],
    store_image: 'https://upload.wikimedia.org/wikipedia/commons/3/35/KFC_logo.svg'
  },
  {
    name: 'Domino\'s Pizza',
    categories: ['Pizzas', 'Complementos', 'Bebidas'],
    products: [
      { name: 'Pepperoni Pizza', price: '120', description: 'Pizza clásica de pepperoni', image_url: 'https://www.dominos.es/managedassets/es/es/product/B_PEP_MES/prod_medium.jpg' },
      { name: 'Pizza Hawaiana', price: '115', description: 'Pizza con piña y jamón', image_url: 'https://www.dominos.es/managedassets/es/es/product/B_HAM_PINE/prod_medium.jpg' },
      { name: 'Pizza Veggie', price: '110', description: 'Pizza vegetariana con vegetales frescos', image_url: 'https://www.dominos.es/managedassets/es/es/product/B_VEG_MES/prod_medium.jpg' },
      { name: 'Alitas BBQ', price: '60', description: 'Alitas bañadas en salsa BBQ', image_url: 'https://www.dominos.es/managedassets/es/es/product/B_BBQ_WING/prod_medium.jpg' },
      { name: 'Pan de ajo', price: '40', description: 'Pan de ajo crujiente', image_url: 'https://www.dominos.es/managedassets/es/es/product/B_GARLIC/prod_medium.jpg' },
      { name: 'Cheesy Bread', price: '45', description: 'Pan relleno de queso derretido', image_url: 'https://www.dominos.es/managedassets/es/es/product/B_CHEESE/prod_medium.jpg' },
      { name: 'Refresco mediano', price: '30', description: 'Refresco mediano a elegir', image_url: 'https://www.dominos.es/managedassets/es/es/product/B_COKE_MED/prod_medium.jpg' },
      { name: 'Tarta de chocolate', price: '50', description: 'Postre de tarta de chocolate', image_url: 'https://www.dominos.es/managedassets/es/es/product/B_CHOC_CAKE/prod_medium.jpg' },
      { name: 'Helado de vainilla', price: '35', description: 'Helado cremoso de vainilla', image_url: 'https://www.dominos.es/managedassets/es/es/product/B_VANILLA/prod_medium.jpg' }
    ],
    store_image: 'https://upload.wikimedia.org/wikipedia/commons/7/74/Dominos_pizza_logo.svg'
  }
]

# Creación de tiendas, categorías y productos
stores_data.each_with_index do |store_data, index|
  user = usuarios_creados[index]

  # Crear categorías
  categories = store_data[:categories].map do |category_name|
    Category.create!(name: category_name)
  end

  # Crear la tienda
  store = Store.create!(
    name: store_data[:name],
    payment_type: 'Tarjeta de Crédito',
    delivery_time: rand(20..40).to_s,
    delivery_price: rand(15..30).to_f,
    user_id: user.id,
    category_id: categories.first.id # Asocia la primera categoría
  )

  attach_photo(store, store_data[:store_image])

  # Crear productos
  store_data[:products].each do |product_data|
    product = Product.create!(
      name: product_data[:name],
      price: product_data[:price],
      description: product_data[:description],
      store_id: store.id
    )
    attach_photo(product, product_data[:image_url])
  end
end

puts "Seeding completed with real data!"
