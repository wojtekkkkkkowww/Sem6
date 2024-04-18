
class NK:
    k = 1 # Default value of k
    def __init__(self, *args):
        
        if len(args) == 1 and isinstance(args[0], list):            
            self.tuples = args[0]
        else:
            self.tuples = list(args)
        
        if len(self.tuples) != NK.k:
            raise ValueError("Number of elements in tuple must be equal to k")
        
    def __le__(self, other):
        # compare all of the elements in tuple
        for i in range(NK.k):
            if self.tuples[i] > other.tuples[i]:
                return False
        return True

    def set_k(k):
        NK.k = k

    # function witch returns the set of minimal elements from subset of NK
    @staticmethod
    def minimal_elements(A):
        pass




# Example usage:
NK.set_k(3)
tuple_set1 = NK(1, 2, 3)
tuple_set2 = NK([1, 2, 3])
print(tuple_set1 <= tuple_set2) 
tuple_set3 = NK([1, 2])

