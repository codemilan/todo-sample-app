def transform( values, format ):
    '''Transforms array of values using format specified (map-like)'''
    return [ format.format( v ) for v in values ]

class FilterModule( object ):
  def filters( self ):
    return { 'transform' : transform }
